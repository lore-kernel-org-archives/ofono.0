Content-Type: multipart/mixed; boundary="===============1632010492896810292=="
MIME-Version: 1.0
From: Gabriel Lucas <gabriel.lucas@smile.fr>
Subject: Re: [PATCH 6/6] gemalto: fix sim reinsertion issue
Date: Mon, 19 Mar 2018 17:01:27 +0100
Message-ID: <661d483f-827e-adf6-a998-ae740324144b@smile.fr>
In-Reply-To: <89854b1f-cb26-e9be-c0cc-aca226ddfb41@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1632010492896810292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,


On 15/03/2018 18:29, Denis Kenzior wrote:
> Hi Gabriel,
>
> Why don't you just use at_util_sim_state_query_new here?
>
> Regards,
> -Denis

This is now done directly in [PATCH 4/6] gemalto: handle sim is inserted =

or removed URCs.

Best regards,
Gabriel

--===============1632010492896810292==--

