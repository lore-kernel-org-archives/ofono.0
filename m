Content-Type: multipart/mixed; boundary="===============3070074789833238723=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [PATCH 4/4] TODO: Marking the Barred Dialing task as done
Date: Mon, 06 Dec 2010 15:22:27 +0200
Message-ID: <B668883EB5DD7144ADFC248A72176EA802C40B22@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <AANLkTimTu-kcCJRucVUfnZvLbZxsXB=6v6A+M_yFfmWk@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3070074789833238723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sankar,

> Is there a way for the clients to enable or disable the Fixed
Dialling? I assume they should be able to do this by using the dbus
calls, "LockPin/UnlockPin".  Is there a =

> way to store the FDN numbers in the sim card? How does ofono validate
the request to be passed to the network when FDN is enabled? Looks like
as per the current =

> implementation of FDN, only emergency calls are allowed. But as per
the 3GPP standards, calls shall be allowed to any number (irrespective
of emergency no) that is part of > the FDN list.  =


Currently, there is no way to enable or disable fixed dialling or Barred
Dialling using oFono. If my assumption is correct, there is no plans to
add support.(Denis/Marcel can confirm this). oFono doesn't support
storing any numbers in the SIM storage(EFadn, EFfdn or EFbdn). Agreed as
per the specification calls shall be allowed to any number that is part
of the FDN list. But its been agreed that oFono will enter presim state
when FDN or BDN service is enabled in which state only emergency calls
are allowed.

> If the modem remains in PRESIM State, how does the mobile receive the
Incoming Calls or SMS? As per my understanding FDN applies in the uplink
and not in the downlink.  =

> Please clarify if my understanding is wrong.

Yes, your understanding is correct. FDN applies to the Mobile originated
calls, SMS etc.

Regards,
Jeevaka

--===============3070074789833238723==--

