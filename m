Content-Type: multipart/mixed; boundary="===============0824270703664326962=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3][RfC] Add utilities for encoding BTLVs and CTLVs.
Date: Mon, 26 Apr 2010 10:28:10 -0500
Message-ID: <201004261028.11557.denkenz@gmail.com>
In-Reply-To: <n2sfb249edb1004260722v33fdbfbag51dcea9ec44c27b5@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0824270703664326962==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> Hi,
> =

> On 23 April 2010 22:09, Denis Kenzior <denkenz@gmail.com> wrote:
> > So I think for the case of the encoder we should bite the bullet and use
> > something like a g_byte_array.  It will be really hard for us to guess
> > the correct buffer size.
> =

> Ok with me, although most of the time we have a limit of 256 bytes per
> PDU or some other limit.  We could also use a growing static buffer to
> avoid having to free the array.

The biggest issue is the text string, you really can't predict the buffer f=
or =

that one.  And I don't want to see 16K+ buffers pre-allocated for this stuf=
f :)

The static buffer of 256 bytes is an optimization we can certainly make for=
 the =

90% case.

> =

> > Let me propose something, tell me if this can be made to work potential=
ly
> > more efficiently:
> >
> > - When we init a ber_tlv, reserve a header at the beginning of the buff=
er
> > to the max size of the tag + length.  The data with CTLVs will be writt=
en
> > after that header.
> > - When we allocate a CTLV, we can set a hint whether this is a
> > potentially 'relocatable' CTLV, or this CTLV will always be of size less
> > than 127 bytes. - When we're done adding CTLVs, we can group our
> > 'memmoves' of those CTLVs which are not relocatable.  For relocatable
> > CTLVs we can set an initial flag on the tag from the set of reserved
> > tags, e.g. 00, FF, etc.
> > - In case the CTLV reaches maximum size, it becomes non-relocatable.
> > - The relocation of BER-TLV is not necessary as we can fill the tag and
> > length information at an offset from the beginning such that the data
> > will follow immediately afterwards.  We simply return the data starting
> > at this offset. - This should hopefully result in not having to use
> > memmove in the most common case.
> =

> I don't think the memmove is much of a problem.  In the most common
> case there's no move needed, e.g. in none of the TERMINAL RESPONSEs
> there will any.  There's one in the mms pdu test I sent.  There will
> never be more than one per BER TLV, and it can be of only 127 bytes
> worst case, so probably faster than all the memory allocs glib does if
> we use GByteArray.

Do you mean C-TLV?  And why 127 bytes?  Wouldn't you have to memmove a =

potentially large array in case a large display text is added?

> =

> > I think we should not try to make generic ber/ctlv encoding utilities,
> > lets concentrate on doing the sim toolkit ones only.  This will allow us
> > to make several simplifications (e.g. not worry about multi-byte ber-tlv
> > tags, etc)
> >
> > Something like:
> >
> > stk_ber_tlv_builder_init(iter, tag);
> > stk_ber_tlv_builder_open_container(iter, container, tag);
> > stk_ber_tlv_builder_close_container(iter, container);
> > stk_ber_tlv_builder_optimize(iter);
> >
> > stk_ctlv_append_byte(iter, byte);
> > stk_ctlv_append_short(iter, short);
> > stk_ctlv_append_data(iter, data, len);
> > stk_ctlv_append_text(iter, text) -> If we can make this work, converts =
to
> > dcs, data format pair
> =

> Sounds ok, but in the end it's a slight complication because you have
> to call "close_container" and "optimize" :).

You can always do the magic to close the container automatically on an =

'open_container' and 'optimize' or re-optimize on each close_container simi=
lar =

to how you're doing it now.  In the end I mostly care about making this eas=
y =

on the encoding code by not having to pre-allocate the buffers or composing=
 the =

pdus before adding them to the TLV.

> =

> Would stk_ber_tlv_builder_open_container always start a CTLV?
> Do you prefer these calls use the generic calls, or do the encoding
> entirely in stkutil.c?

For the purposes of STK work, yes.  You can always come up with a better na=
me =

:)  Right now I don't think we need to solve the generic ber-tlv / simple-t=
lv =

/ comprehension tlv composition problem, so doing it entirely in stkutil.c =
is =

fine.  Do you foresee a need to make these generic?

Regards,
-Denis

--===============0824270703664326962==--

