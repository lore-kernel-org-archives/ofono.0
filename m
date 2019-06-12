Content-Type: multipart/mixed; boundary="===============2730695207753297616=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] xmm7modem: fix to activate context with cid zero
Date: Wed, 12 Jun 2019 09:57:06 -0500
Message-ID: <df240cfb-5bbb-4def-f4cf-b8573682136e@gmail.com>
In-Reply-To: <9BCC1739A7EADA4790E1FFF4123FB3268BB1F9B0@BGSMSX101.gar.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2730695207753297616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 06/12/2019 12:46 AM, Borwankar, Antara wrote:
> Hi Denis,
> =

> All the XMM modems return cid=3D0 for default PDP context. +CGDCONT respo=
nse from modem is as below.
> +CGDCONT: 0,"IP","cmw500.rohde-schwarz.com","172.22.1.100",0,0,0,0,0,0,0,=
0,0,0
>   =

> Setting  last_auto_context_id 0XFF also does not work since that is reser=
ved to be assigned for Network initiated case.

What is the output of +CGDCONT=3D?  And why in the world would the modem =

team pick 0xff for this?  Don't they support multiple network-initiated =

contexts? Sheesh.

Anyhow, you can still make last_auto_context_id into a signed integer. =

So setting it to -1 should be sufficient even to cover the weird 0xff case.

Regards,
-Denis

--===============2730695207753297616==--

