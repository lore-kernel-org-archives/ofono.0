Content-Type: multipart/mixed; boundary="===============8192080688707832405=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: Re: [RFC PATCH 1/4] sim: check if FD is enabled in the SIM-card
Date: Mon, 04 Oct 2010 15:19:49 +0300
Message-ID: <201010041519.49934.petteri.tikander@ixonos.com>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802AA1144@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8192080688707832405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Jeevaka.

Well yes, function naming is misleading. I just had some idea for collectin=
g =

different kind of call-restrictions (FDN, BDN, other?) under the same check=
ing =

function sim_call_barring_check(), which now supports only FDN.
Well perhaps changing name from sim_call_barring_check() to =

sim_call_restriction_check() would be more descriptive?

Then it could call proper driver-functions. OK, I'll change driver-function =

query_call_barred() to something more descriptive for Fixed Dial-purpose.

Br, Petteri


> Function names are misleading(eg: query_call_barred,
> sim_call_barring_check). Is it better to use the function name like
> query_fdn_status??
> =

> Regards,
> jeevaka


--===============8192080688707832405==--

