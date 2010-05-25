Content-Type: multipart/mixed; boundary="===============4171709585278598819=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/27] Add utilities for encoding BTLVs and CTLVs.
Date: Tue, 25 May 2010 16:36:48 -0500
Message-ID: <201005251636.49119.denkenz@gmail.com>
In-Reply-To: <1274018488-6289-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4171709585278598819==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> This version merges ber_tlv_builder_next and _set_tag into one function,
> same for comprehension tlvs.  The ber_tlv_iter and ber_tlv_builder
> structs are not merged because the pointers in _iter need to be const
> else ugly casting is needed.

So I applied the first 21 patches in this series with some cleanups in betw=
een. =

All the unit tests still pass, but please recheck that I didn't screw =

something up.

Regards,
-Denis

--===============4171709585278598819==--

