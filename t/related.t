use strict;
use warnings;
use Path::Tiny;
use Data::UUID;

use Test::More tests => 1;

use lib qw(./lib);

use Text::vCard::Precisely::V3;

my $vc = Text::vCard::Precisely::V3->new();

my $ug = Data::UUID->new;
$vc->fn('John Smith');

my $uuidj = $ug->create_from_name_str( NameSpace_URL, 'john@example.com' );
my $uuidt = $ug->create_from_name_str( NameSpace_URL, 'tim@example.com' );
$vc->uid("urn:uuid:$uuidj");
$vc->related({ types => ['co-worker'], value => "urn:uuid:$uuidt" });

my $in_file = path( 't', 'related.vcf' );
my $expected_content = $in_file->slurp_utf8;

is $vc->as_string, $expected_content, 'related(Data::UUID)';                # 1

done_testing;
