Content-Type: multipart/mixed; boundary="===============6827397169625661668=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: Re: [PATCH 3/5] cdma-atmodem: Add CDMA MO Call Support
Date: Fri, 10 Dec 2010 13:41:58 -0800
Message-ID: <1292017318.4927.67.camel@dardoyle-desktop>
In-Reply-To: <4D00969F.9070303@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6827397169625661668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis

On Thu, 2010-12-09 at 09:43 +0100, ext Denis Kenzior wrote:

> =

> >  drivers/cdma-atmodem/atutil.c    |   45 +++++++++
> >  drivers/cdma-atmodem/atutil.h    |   65 +++++++++++++
> =

> Are these verbatim copies of atmodem/atutil.[ch]?  If so, then there's
> no reason why you can't re-use those.  No need to copy them.

No, they are not verbatim copies as e.g. error decoding is different.
Would you prefer we clarify this by renaming the files cdmautil.(ch)?

> > +
> > +     ofono_cdma_voicecall_manager_disconnected(req->vc,
> > +                             OFONO_DISCONNECT_REASON_LOCAL_HANGUP, NUL=
L);
> > +             CALLBACK_WITH_SUCCESS(req->cb, req->data);
> > +
> =

> Why the extra empty line?
> =

> How do we handle remote side hanging up?

This is future work as part of the overall design of call state
management with transitions initiated from the modem.
Our current hardware has limitations where such notifications are not
supported.

Cheers
Dara



--===============6827397169625661668==--

