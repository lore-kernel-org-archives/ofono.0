Content-Type: multipart/mixed; boundary="===============0019175702506759439=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 1/2] smsutil: national to international conversion in
 status report
Date: Fri, 17 Sep 2010 13:15:22 -0500
Message-ID: <4C93B03A.6060701@gmail.com>
In-Reply-To: <201009172024.47124.petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0019175702506759439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri,

>> So my thinking is that for efficiency purposes we should try the direct
>> lookup first.  We don't want to pay the penalty of walking the entire
>> hash table every time for networks that are 'sane'.  If that fails, fall
>> back to the 'fuzzy' lookup.  This would also make the code a bit easier
>> to follow I think...
> =

> OK. Direct lookup would do this same and look nicer. But I think (but not =

> sure) that g_hash_table_lookup() does similar looping internally, as my =

> addition for while-looping address-tables. Well I was already taking =

> g_hash_table_lookup() back, but just making the code uglier when adding =

> 'international to national'-logic. That's because of iterating msg-id nod=
es, =

> so solution lead to two node-iteration loops.

Both looping and g_hash_table_lookup can be thought of as O(n) in the
worst case.  However, in the average case the hash table is way faster,
like O(1) or so.  The hash table is essentially an array, and the
hashing function computes an index in the array...

> =

> My idea was to find suitable address&Mr-pair. So if address matches but M=
R =

> doesn't, let's continue (while-loop inside while-loop).
> Was your idea actually that this inefficency-problem in looping occurs ac=
tually =

> in this point: if for some reason in sane networks the address matches, b=
ut MR =

> doesn't, function continues looping although it shouldn't? And then it lo=
ops =

> the entire table. In 'insane'-networks this is OK, because function is no=
t =

> comparing necessarily the whole address?

So think of it like this, if a status report arrives from a 'sane
network', the g_hash_table_lookup (e.g. how we do it today) will give us
the sender address right away.  In the best case we compute the index of
the address hash table node in time O(1), more if there are collisions.
 We then perform a linear search on the status report assembly nodes
associated with that address.

If the address was found, but no MR was, then simply discard the status
report.  The fuzzy match will fail or give us the wrong answer anyway.

Only if the address was not found by direct lookup (e.g. the status
report is from an insane network or simply mis-addressed /
mis-delivered) should we go and try performing a fuzzy match.

In general fast-tracking the most common path is a good idea.  It makes
things seem faster in general.

Regards,
-Denis

--===============0019175702506759439==--

