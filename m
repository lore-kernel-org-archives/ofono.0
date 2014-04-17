Content-Type: multipart/mixed; boundary="===============4389118151729627414=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] mbpi: Parse gsm provider name
Date: Thu, 17 Apr 2014 10:40:26 -0500
Message-ID: <534FF5EA.3000900@gmail.com>
In-Reply-To: <534F8FA2.9020709@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4389118151729627414==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

Please do not top-post on this mailing list.

On 04/17/2014 03:24 AM, Slava Monich wrote:
> Hi Denis,
> It's for custom provisioning plugins.
> =

> Service provider name is passed to the provisioning plugin but not used
> there at all. This patch makes it possible to utilize it for AP matching.
> =


I still do not understand.  SPN is passed to the provisioning plugin via
get_settings.  I do not see any need for it to be stored in
ofono_gprs_provision_data struct.  How is it going to be used by the core?

Regards,
-Denis

--===============4389118151729627414==--

