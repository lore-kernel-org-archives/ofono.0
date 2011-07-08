Content-Type: multipart/mixed; boundary="===============4977021750021559307=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] phonesim: add support of +CBC
Date: Fri, 08 Jul 2011 13:25:15 -0500
Message-ID: <4E174B8B.1040300@gmail.com>
In-Reply-To: <1310131760-5611-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4977021750021559307==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 07/08/2011 08:29 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> PTS test TP/PSI/BV-03-I [Transfer Battery Level Indication] needs to
> change battery level and check that the battery level indication is
> received at the HF.
> So add support for +CBC in phonesim plugin, and force update of the
> battery indicator on HFP AG Emulator registration.
> ---
>  plugins/phonesim.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 64 insertions(+), 0 deletions(-)
> =


Patch looks great and has been applied, thanks.

Regards,
-Denis

--===============4977021750021559307==--

