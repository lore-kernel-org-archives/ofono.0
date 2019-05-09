Content-Type: multipart/mixed; boundary="===============3655387232101536904=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [RFC at-export 2/2] ublox: network-registration atom
Date: Thu, 09 May 2019 09:30:30 +0200
Message-ID: <CAHB-Pjmd+c-80fDJL6OFS71NUn3j8nFebZ_EK3ybk_n2SM2yeg@mail.gmail.com>
In-Reply-To: <d87fb647-af8c-cb0c-2462-aba49d45533c@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3655387232101536904==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Den ons 8 maj 2019 kl 16:37 skrev Denis Kenzior <denkenz@gmail.com>:
>
> Hi Richard,
> >
> > Just wants to check your thoughts about CREG and LTE only...
> > If the modem only has 4g coverage it might set the status to 4 (unknown=
),
> > but ureg would indicate LTE(7).
> > I have done a local patch for this in gprs, do not go to de-attached
> > state in that case.
>
> It seems a bunch of devices have this problem.  By my reading of 27.007,
> CREG should not report status 4 unless there is no coverage whatsoever,
> e.g.:
>
> "4      unknown (e.g. out of GERAN/UTRAN/E-UTRAN coverage)"
>
> >
> > Just wondering if we should combine the CREG and UREG status
> > in some way, the problem is that UREG is not indicating roaming or not.=
..
>
> So that sounds like a bug in the firmware.  Does ublox support +CEREG?

Yes they support CEREG according to the AT spec. I have not looked
into the difference, do you have an executive, summary? ;)

It might be a firmware issue. I have seen multiple cases where it
reports unknown but UREG =3D 7... AND the LTE context still works.

--Richard

--===============3655387232101536904==--

