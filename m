Content-Type: multipart/mixed; boundary="===============1229950365011683934=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Reg. How client receives SMS PUD
Date: Mon, 21 Jun 2010 09:28:44 -0500
Message-ID: <201006210928.44459.denkenz@gmail.com>
In-Reply-To: <AANLkTikiCGSyn775gEHTejkdJNtcfTNZBe6N68ebm57n@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1229950365011683934==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Satya,

> Hi all,
> =

> oFono stack decodes the incoming PDU. Is there any option that client can
> receive the direct PDU from oFono with out processing (i.e. decoding).

This feature is only planned for reception of SMS Application Source / =

Destination port addressing PDUs.  oFono will not support this for regular =

text messages.  What use case do you have in mind here?

> =

> If such option available, how can I achieve this.
> =

> Similarly in case sending message oFono will form (encode) the PDU based =
on
> the data passed to it. Instead is there any possibility that client can
>  form the PDU and send it to oFono stack ?

There's no way to submit a PDU directly to oFono.  If you want to send =

arbitrary PDUs then you'll need to extend the sms atom API and write a plug=
in =

to do so.

For both of these topics, please see the oFono TODO file (SMS section) for =
our =

plans in this area.

Regards,
-Denis

--===============1229950365011683934==--

