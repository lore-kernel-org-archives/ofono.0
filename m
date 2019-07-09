Content-Type: multipart/mixed; boundary="===============5378721647938675812=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [PATCH 09/10] quectel: add basic support for serial connected
 modems
Date: Tue, 09 Jul 2019 08:50:44 +0200
Message-ID: <1eb425dc-cdda-a723-176f-cef89370ab67@geanix.com>
In-Reply-To: <95f32004-bbbe-b70b-7d23-b97c7589da69@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5378721647938675812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 08/07/2019 18.12, Denis Kenzior wrote:
> However, there is still the fundamental issue of not being able to =

> correlate the created ttys to the original one...=C2=A0 If we can fix tha=
t in =

> the kernel, then a strong argument can be made to drop GAtMux entirely. =

> Which is actually what I would prefer as it would make conversion to ell =

> much easier.

Let's see how it goes:
https://lore.kernel.org/patchwork/patch/1098922/

It won't make it in until v5.4, so either we support both n_gsm and =

gatmux, or we fall back to /dev/gsmtty1 as base if GSMIOC_GETBASE isn't =

defined.

// Martin

--===============5378721647938675812==--

