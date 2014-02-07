Content-Type: multipart/mixed; boundary="===============1392463280057622733=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Unable to connect Huawei HiLink E303
Date: Fri, 07 Feb 2014 08:42:41 -0600
Message-ID: <52F4F0E1.5060201@gmail.com>
In-Reply-To: <CAK+sfos3VjuGfmDyMhkbf6RpPBUXOH5-8guiPSnUDjo8Axm3hA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1392463280057622733==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Homam,

Please do not top-post on this mailing list.

On 02/06/2014 11:37 AM, Homam Dabis wrote:
> Cool. That worked. Can you please explain?
>

It seems that your modem firmware does not like +CGDATA command for some =

reason.

Feel free to clean up the patch and enable this modem properly.

You will most likely need to set a property in udevng based on the E303 =

USB hardware id.  Then inside plugins/huawei.c set the quirk based on =

that property.

Alternatively you can set the quirk based on the firmware / model revision.

Regards,
-Denis

--===============1392463280057622733==--

