package Data::Tabulate::Plugin::HTMLTable;

use warnings;
use strict;
use HTML::Table;

# ABSTRACT: HTML::Table plugin for Data::Tabulate

our $VERSION = '0.03';

=head1 SYNOPSIS

This module renders the table for HTML

    use Data::Tabulate;
    
    my @array = (1..10);
    my $foo   = Data::Tabulate->new();
    my $html  = $foo->render('HTMLTable',{data => [@array]});

=method new

create a new object of C<Data::Tabulate::Plugin::HTMLTable>.

=cut

sub new{
    return bless {},shift;
}

=method output

returns a string that contains the HTML source for the table

=cut

sub output {
    my ($self,@data) = @_;
    
    my %atts = $self->attributes();
    my $obj  = HTML::Table->new(%atts);
    for(@data){
        my @row = map{defined($_) ? $_ : '&nbsp;'}@$_;
        $obj->addRow(@row);
    }
    
    return $obj->getTable();
}

=method attributes

set some attributes for L<HTML::Table>.

=cut

sub attributes{
    my ($self,%atts) = @_;
    $self->{attributes} = {%atts} if keys %atts;
    my %return = ();
    if(defined $self->{attributes} and ref($self->{attributes}) eq 'HASH'){
        %return = %{$self->{attributes}}
    }
    return %return;
}

1; # End of Data::Tabulate::Plugin::HTMLTable
