package Data::Tabulate::Plugin::HTMLTable;

use warnings;
use strict;

use HTML::Table;

# ABSTRACT: HTML::Table plugin for Data::Tabulate

our $VERSION = '0.04';

=head1 SYNOPSIS

This module renders the table for HTML

    use Data::Tabulate;
    
    my @array = (1..10);
    my $foo   = Data::Tabulate->new();
    my $html  = $foo->render('HTMLTable',{data => [@array]});

=method new

create a new object of C<Data::Tabulate::Plugin::HTMLTable>.

    my $obj = Data::Tabulate::Plugin::HTML::Table->new;

=cut

sub new{
    return bless {},shift;
}

=method output

returns a string that contains the HTML source for the table

    my $html_table = $obj->output(
        ['a1', 'b1', 'c1' ],
        ['a2', 'b2', 'c2' ],
        ['a3', 'b3', 'c3' ],
    );

=cut

sub output {
    my ($self,@data) = @_;
    
    my %atts = $self->attributes();
    my $obj  = HTML::Table->new(%atts);

    for my $row_data ( @data ){
        my @row = map{ defined $_ ? $_ : '&nbsp;' }@{$row_data};
        $obj->addRow(@row);
    }
    
    return $obj->getTable();
}

=method attributes

set some attributes for L<HTML::Table>.

    my $obj = Data::Tabulate::Plugin::HTML::Table->new;
    $obj->attributes(
        -border => 1,
        -bgcolor => 'red',
    );

    my $html_table = $obj->output(
        ['a1', 'b1', 'c1' ],
        ['a2', 'b2', 'c2' ],
        ['a3', 'b3', 'c3' ],
    );

=cut

sub attributes{
    my ($self,%atts) = @_;

    $self->{attributes} = {%atts} if keys %atts;

    my %return = %{ $self->{attributes} || {} };

    return %return;
}

1; # End of Data::Tabulate::Plugin::HTMLTable
