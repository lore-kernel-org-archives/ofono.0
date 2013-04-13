Content-Type: multipart/mixed; boundary="===============6583453198366615515=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [PATCH v2 2/7] include: ofono_handsfree_card_select_codec()
Date: Sat, 13 Apr 2013 20:34:29 -0300
Message-ID: <20130413233429.GA30834@echo>
In-Reply-To: <516894D9.2090807@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6583453198366615515==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 18:12 Fri 12 Apr, Denis Kenzior wrote:
> Hi Vinicius,
> =

> On 04/10/2013 02:37 PM, Vinicius Costa Gomes wrote:
> >This will be used by the drivers that a given codec was negotiated
> >for a card.
> >---
> >  include/handsfree-audio.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> >diff --git a/include/handsfree-audio.h b/include/handsfree-audio.h
> >index 82d1312..2e58c43 100644
> >--- a/include/handsfree-audio.h
> >+++ b/include/handsfree-audio.h
> >@@ -48,6 +48,8 @@ struct ofono_handsfree_card *ofono_handsfree_card_crea=
te(unsigned int vendor,
> >  							void *data);
> >  int ofono_handsfree_card_register(struct ofono_handsfree_card *card);
> >  void ofono_handsfree_card_remove(struct ofono_handsfree_card *card);
> >+void ofono_handsfree_card_select_codec(struct ofono_handsfree_card *car=
d,
> >+							unsigned char codec);
> =

> As mentioned before, lets make this return ofono_bool_t and name it
> 'set_codec'.
> =

> Also, do we have some idea whether codec ids are limited to 8 bits
> or they can be larger?  My reading of the spec would seem to
> indicate 8 bits maximum.

That is also my reading. From the spec, section 4.34.1, page 92: "The format
of the Codec IDs is 8 bit aliases that are defined in section 12".

> =

> >
> >  ofono_bool_t ofono_handsfree_audio_has_wideband(void);
> >
> =

> Regards,
> -Denis


Cheers,
-- =

Vinicius

--===============6583453198366615515==--

