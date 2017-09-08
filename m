Content-Type: multipart/mixed; boundary="===============6977768972876015580=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/7] udev: fix quectelqmi gps interface
Date: Fri, 08 Sep 2017 11:06:05 -0500
Message-ID: <04a13315-4bc6-3941-e2c1-8ec7567fe656@gmail.com>
In-Reply-To: <20170908024040.31418-6-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6977768972876015580==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 09/07/2017 09:40 PM, Jonas Bonn wrote:
> Using location-reporting requires both the 'aux' and 'gps' interfaces;
> the GPS interface is interface 1, not 2.
> ---
>   plugins/udevng.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============6977768972876015580==--

