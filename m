Content-Type: multipart/mixed; boundary="===============6984523386030441800=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/7] extended support for LTE and NR. Some minor fixes.
 part 2 of 7
Date: Thu, 20 Sep 2018 11:31:26 -0500
Message-ID: <ad8cc686-16ea-5c20-a95a-4e452cb632cc@gmail.com>
In-Reply-To: <CAKSBH7Ftoq2DPS__76jiucqZ_U179sjWdgNr5s3wzmsHNGD_Ag@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6984523386030441800==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

> The idea would be to just store the values in the driver but not in the =

> module,
> and then send them before attaching, so that the verification can be =

> consistent and all,
> just like for the gprs-context atom.

Yes, but that is not what you outlined in the code.  You were watching =

for SIM_STATE_READY which only means just that.

Also note that we can bring the modem online even in pre_sim state (e.g. =

for emergency calls), in which case the lte atom doesn't exist yet.

> =

> so the idea would be to check if a new method, that I have tentatively =

> called set_property(),
> exists. If so, use the reviewed stile above, otherwise fallback to the =

> current function.
> =


I don't see what set_property is buying you.  Anyway, feel free to come =

up with a more detailed proposal, but my impression is that this =

approach will quickly become way too complicated.

Regards,
-Denis

--===============6984523386030441800==--

