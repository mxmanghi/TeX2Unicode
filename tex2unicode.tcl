#
# -- tex2unicode.tcl
# 
# Conversion utility for TeX characters coded as diacritics.
# This package provides a 'convert' command that accepts strings containing
# LaTeX diacritical marks and returns a Unicode representation of the string.
# The package does not provide a complete conversion utility of symbols and
# characters as represented in (La)Tex. It's mostly useful with western languages
# that use extended character sets and, even though marginal, there are corners
# of the western extended character sets that are still not supported (see below)
#
# The problem of handling strings containing diacritical LaTex character
# representations is common when handling references in Bibtex style citations
# 
# Examples:
#
#   \'{e} which translates as 'é' or
#   \"{u} which translates as 'ü' etc
#
#   supported diacritics
#
#   - " umlaut
#   - ^ circumflex
#   - ' acute accent
#   - ` grave accent
#   - ~ tilde
#   - c cedilla
#   - = macron (solid line atop a character as in ā)
#   - u breve (u shaped trait atop a character as in ă)
#   - v caron (v shaped trait atop a character as in č)
#   - . dot above a character
#   - r ring over a letter (as in å)
#   - H double acute accent as in Ő
#   - k letters with ogonek (as in ą) used in Polish and Lituanian 
#
# Limitations: the package checkes for \x{y} patterns, simplified coding
# such as \'e still not handled.
#
# The package is incomplete. For instance double grave diacritical marks
# conversion is still to be figured out. The support for
# the set of diacritical marks for the Basic Latin and for the Ogonek marks 
# in the Latin extended-A sets is fairly complete.
# The problem of supporting shorthand notation for the certain class of
# characters (e.g. \r{a} that can be made as \aa) requires a more
# elaborate pattern matching to be implemented
#
# The package was developed to deal with LaTex diacritics that appear in
# 
#

namespace eval tex2unicode {
    variable conversion_map [dict create \
                                        \
    \" [dict create a \u00e4 A \u00c4   \
                    e \u00eb E \u00cb   \
                    i \u00ef I \u00cf   \
                    o \u00f6 O \u00d6   \
                    u \u00fc U \u00dc]  \
                                        \
    ^  [dict create a \u00e2 A \u00c2   \
                    e \u00ea E \u00ca   \
                    i \u00ee I \u00ce   \
                    o \u00f4 O \u00d4   \
                    u \u00fb U \u00db   \
                    C \u0108 c \u0109   \
                    G \u011c g \u011d   \
                    W \u0174 w \u0175   \
                    Y \u0176 y \u0177]  \
                                        \
    '  [dict create a \u00e0 A \u00c0   \
                    e \u00e8 E \u00c8   \
                    i \u00ec I \u00cc   \
                    o \u00f2 O \u00d2   \
                    u \u00f9 U \u00d9]  \
                                        \
    `  [dict create a \u00e1 A \u00c1   \
                    e \u00e9 E \u00c9   \
                    i \u00ed I \u00cd   \
                    o \u00f3 O \u00d3   \
                    u \u00fa U \u00da   \
                    y \u00fd Y \u00dd]  \
                                        \
    ~  [dict create a \u00e3 A \u00c3   \
                    i \u0129 I \u0128   \
                    n \u00f1 N \u00d1   \
                    o \u00f5 O \u00d5]  \
                                        \
    c  [dict create c \u00e7 C \u00c7   \
                    G \u0122 g \u0123   \
                    K \u0136 k \u0137   \
                    L \u013b l \u013c   \
                    N \u0145 n \u0146   \
                    R \u0156 r \u0157   \
                    S \u015e s \u015f   \
                    T \u0162 t \u0163]  \
                                        \
    =  [dict create A \u0100 a \u0101   \
                    E \u0112 e \u0113   \
                    I \u012a i \u012b   \
                    O \u014c o \u014d   \
                    U \u016a u \u016b]  \
                                        \
    u  [dict create A \u0102 a \u0103   \
                    E \u0114 e \u0115   \
                    I \u012c i \u012d   \
                    O \u014e o \u014f   \
                    U \u016c u \u016d]  \
                                        \
    v [dict create  C \u010c c \u010d   \
                    D \u010e d \u010f   \
                    E \u011a e \u011b   \
                    L \u013d l \u013e   \
                    N \u0147 n \u0148   \
                    R \u0158 r \u0159   \
                    S \u0160 s \u0161   \
                    T \u0164 t \u0165   \
                    Z \u017d z \u017e]  \
                                        \
    . [dict create  C \u010a c \u010b   \
                    E \u0116 e \u0117   \
                    G \u0120 g \u0121   \
                    I \u0130            \
                    Z \u017b z \u017c]  \
                                        \
    r [dict create  A \u00c5 a \u00e5   \
                    U \u016e u \u016f]  \
                                        \
    H [dict create  O \u0150 o \u0151   \
                    U \u0170 u \u0171]  \
                                        \
    k [dict create  A \u0104 a \u0105   \
                    E \u0118 e \u0119   \
                    I \u012e i \u012f   \
                    U \u0172 u \u0173   \
                    O \u01ea o \u01eb]  \
]

    proc to_latex {unicode_string} {
        return ""
    }
    namespace export to_latex

    proc to_unicode {TeXString} {
        variable conversion_map

        # the diacritical patterns are located in the input string

        set patterns [regexp -inline -all {\\(.){(\w)}} $TeXString]
        
        set pattern_map [dict create]

        # this builds a pattern map represented with a 2 level dictionary
        # where the first level key is the TeX diactritical mark modifier
        # and the second key the letter
        
        # creating a pattern map and at the same time filtering out unsupported
        # sequences

        foreach {k s1 s2} $patterns { 
            if {[dict exists $conversion_map $s1 $s2]} {
                dict set pattern_map $k [dict create $s1 $s2] 
            }
        }

        # list of pattern - substitution to be used within a string map

        set smap [dict map {k v} $pattern_map {dict get $conversion_map {*}$v}]
        return [string map $smap $TeXString]
    }

    proc convert {tex_string} {
        return [to_unicode $tex_string]
    }
    namespace export convert

    namespace ensemble create
}

package provide tex2unicode 1.0
#
