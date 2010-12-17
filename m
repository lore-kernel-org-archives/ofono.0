Content-Type: multipart/mixed; boundary="===============6861700102154107011=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: TODO: Network updating the emergency number list
Date: Fri, 17 Dec 2010 14:54:10 -0600
Message-ID: <4D0BCDF2.2000702@gmail.com>
In-Reply-To: <C681C76E0D5F1E4BB01DE79E0A80EEC702DE3898@usrdes03.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6861700102154107011==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rajesh,

>> Can you do me a favor and investigate what oFono's behavior =

>> should be if we receive emergency numbers that are not =

>> relevant to the currently registered PLMN?  We should also =

>> update the task description with the above.
> =

> The ECC list downloaded from the network are country specific ones, =

> so this ECC list usually can be notified by any available network not =

> necessarily by the serving network. The ECC list thats downloaded from =

> the serving network has to be reset when the phone registers in another =

> network with a different MCC ( not MNC ), as this ECC list is country =

> specific not operator specific.
>

Sounds reasonable.  Is this relevant only when the ME is registered with
the IMSI known or also when the SIM is not present / PIN not entered?
For these cases, what happens when we're in an area with multiple
networks with multiple MCCs.

Final question, is there a spec that describes this behavior?

Regards,
-Denis

--===============6861700102154107011==--

