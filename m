Content-Type: multipart/mixed; boundary="===============5542343836293782190=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/7] Add CHLD support to HFP profile
Date: Wed, 04 May 2011 22:37:27 -0500
Message-ID: <4DC21B77.20904@gmail.com>
In-Reply-To: <1304351288-3894-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5542343836293782190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 05/02/2011 10:48 AM, Fr=C3=A9d=C3=A9ric Dalleau wrote:
> This patch adds CHLD support to HFP profile.
> =

> AT+CHLD=3D0 uses release_all_held and set_udub
> AT+CHLD=3D1 uses release_all_active
> AT+CHLD=3D2 uses hold_all_active
> AT+CHLD=3D3 uses create_multiparty
> AT+CHLD=3D4 uses transfer
> AT+CHLD=3D1X uses release_specific
> AT+CHLD=3D2X uses private_chat
> =

> Best regards!
> =


I applied all patches in this series, however I did make a few refactor
commits afterwards.  Please check and make sure I didn't screw anything up.

Regards,
-Denis

--===============5542343836293782190==--

