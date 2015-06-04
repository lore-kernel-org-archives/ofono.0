Content-Type: multipart/mixed; boundary="===============3323701877241853794=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Problems provisioning APN from SIMs
Date: Thu, 04 Jun 2015 18:48:58 -0500
Message-ID: <5570E3EA.80904@gmail.com>
In-Reply-To: <28A32924-FC04-49AD-97CA-4AC835D0ED2E@holtmann.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3323701877241853794==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

 >
> The actual MCC and MNC assignments are ITU T E.212 and the (U)SIM Header =
of the ICCID is ITU T E.118 document.
>
> And as a side note, the (U)SIM Header is between 6 and 7 digits. The MNC =
is between 2 and 3 digits.

So in theory E212 should be enough.  Each operator (MVNO or otherwise) =

should have its own MCC/MNC identifier.  However, this practice came in =

too late to the game, so this is not true in reality.

Many operators assigned MVNO SIMs out of their pool, resulting in chaos. =

  Hence why DBs resort to playing tricks with EFspn, EFgid1, etc.

I suspect newly issues SIMs do not have this problem, but it might still =

be relevant for SIMs issued in the past.

Regards,
-Denis

--===============3323701877241853794==--

