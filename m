Content-Type: multipart/mixed; boundary="===============0436442508035930327=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH 04/16] emulator: Add APIs to send GAtServer result
Date: Fri, 13 Aug 2010 15:06:03 +0200
Message-ID: <1281704763.23399.12.camel@localhost.localdomain>
In-Reply-To: <33AB447FBD802F4E932063B962385B3528F0C2A9@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0436442508035930327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> >> Defines APIs to send final/intermediate/unsolicited result to DUN
> >> client. ---
> >>  include/emulator.h |    2 ++
> >>  src/emulator.c     |   28 ++++++++++++++++++++++++++++
> >>  src/ofono.h        |   11 +++++++++++
> >>  3 files changed, 41 insertions(+), 0 deletions(-)
> >> =

> >> diff --git a/include/emulator.h b/include/emulator.h
> >> index 29e87b9..2a45c65 100644
> >> --- a/include/emulator.h
> >> +++ b/include/emulator.h
> >> @@ -36,6 +36,8 @@ enum ofono_emulator_status {
> >>  	OFONO_EMULATOR_STATUS_DESTROY,
> >>  };
> >> =

> >> +enum _GAtServerResult;
> >> +
> > =

> > this is not good. It should not be needed outside of GAtChat. Why not
> > just include gatserver.h?
> =

> My original purpose is to avoid including another gatserver header in .h =
file.
> So far, we don't include gatchat.h/gatserver.h in oFono core header file.
> =

> > And in addition the _GAt declaration should never be used. Why not use
> > the typedef one?
> =

> If we allow to include gatserver.h, this problem is gone. We do have type=
def
> in gatserver.h.

good point here, but your way of avoiding this is not really clean
either. Lets discuss this with Denis and see what he thinks.

Regards

Marcel



--===============0436442508035930327==--

