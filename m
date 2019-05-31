Content-Type: multipart/mixed; boundary="===============1537605468047293162=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] xmm7modem: enabling simtoolkit for xmm7modem
Date: Fri, 31 May 2019 10:21:40 -0500
Message-ID: <b2b58870-7577-37a0-0d9b-f64e559d7280@gmail.com>
In-Reply-To: <9BCC1739A7EADA4790E1FFF4123FB3268BB0FC01@BGSMSX101.gar.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1537605468047293162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 05/31/2019 12:25 AM, Borwankar, Antara wrote:
> Hi Denis,
> =

> Xmm modem send proactive command for set up menu only at sim initializati=
on, also depending upon if stk is enabled. So before sim initialization we =
have to make sure the stk is enabled otherwise proactive command is missed.
> =


Yes, I get that STK is initialized right after SIM is =

unlocked/initialized.  That is just the nature of usat is done and every =

modem works about the same way.  I'm just warning you that stk was never =

meant to work in pre_sim.  It was only pre-certified with a 6160 in =

post_sim; so you run the risk of causing issues elsewhere.

In the end it is your driver, so I can take the patch if you insist, but =

I really would recommend you solve this properly.

Every modem we had in the past had no issue with stk being in post_sim.
Maybe you want to provide an AT trace showing why STK needs to be in =

pre_sim?

Regards,
-Denis

--===============1537605468047293162==--

