Content-Type: multipart/mixed; boundary="===============8928337366309746612=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [PATCH 2/3][RfC] Add utilities for encoding BTLVs and CTLVs.
Date: Mon, 26 Apr 2010 16:22:33 +0200
Message-ID: <n2sfb249edb1004260722v33fdbfbag51dcea9ec44c27b5@mail.gmail.com>
In-Reply-To: <201004231509.20187.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8928337366309746612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 23 April 2010 22:09, Denis Kenzior <denkenz@gmail.com> wrote:
> So I think for the case of the encoder we should bite the bullet and use
> something like a g_byte_array. =C2=A0It will be really hard for us to gue=
ss the
> correct buffer size.

Ok with me, although most of the time we have a limit of 256 bytes per
PDU or some other limit.  We could also use a growing static buffer to
avoid having to free the array.

>
> Let me propose something, tell me if this can be made to work potentially=
 more
> efficiently:
>
> - When we init a ber_tlv, reserve a header at the beginning of the buffer=
 to
> the max size of the tag + length. =C2=A0The data with CTLVs will be writt=
en after
> that header.
> - When we allocate a CTLV, we can set a hint whether this is a potentially
> 'relocatable' CTLV, or this CTLV will always be of size less than 127 byt=
es.
> - When we're done adding CTLVs, we can group our 'memmoves' of those CTLVs
> which are not relocatable. =C2=A0For relocatable CTLVs we can set an init=
ial flag on
> the tag from the set of reserved tags, e.g. 00, FF, etc.
> - In case the CTLV reaches maximum size, it becomes non-relocatable.
> - The relocation of BER-TLV is not necessary as we can fill the tag and l=
ength
> information at an offset from the beginning such that the data will follow
> immediately afterwards. =C2=A0We simply return the data starting at this =
offset.
> - This should hopefully result in not having to use memmove in the most c=
ommon
> case.

I don't think the memmove is much of a problem.  In the most common
case there's no move needed, e.g. in none of the TERMINAL RESPONSEs
there will any.  There's one in the mms pdu test I sent.  There will
never be more than one per BER TLV, and it can be of only 127 bytes
worst case, so probably faster than all the memory allocs glib does if
we use GByteArray.

>
> I think we should not try to make generic ber/ctlv encoding utilities, le=
ts
> concentrate on doing the sim toolkit ones only. =C2=A0This will allow us =
to make
> several simplifications (e.g. not worry about multi-byte ber-tlv tags, et=
c)
>
> Something like:
>
> stk_ber_tlv_builder_init(iter, tag);
> stk_ber_tlv_builder_open_container(iter, container, tag);
> stk_ber_tlv_builder_close_container(iter, container);
> stk_ber_tlv_builder_optimize(iter);
>
> stk_ctlv_append_byte(iter, byte);
> stk_ctlv_append_short(iter, short);
> stk_ctlv_append_data(iter, data, len);
> stk_ctlv_append_text(iter, text) -> If we can make this work, converts to=
 dcs,
> data format pair

Sounds ok, but in the end it's a slight complication because you have
to call "close_container" and "optimize" :).

Would stk_ber_tlv_builder_open_container always start a CTLV?
Do you prefer these calls use the generic calls, or do the encoding
entirely in stkutil.c?

Regards

--===============8928337366309746612==--

