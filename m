Content-Type: multipart/mixed; boundary="===============1291151110787693783=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: rfcomm kernel module isn't loaded with version >= 1.13
Date: Fri, 14 Feb 2014 13:13:13 -0600
Message-ID: <52FE6AC9.1040301@gmail.com>
In-Reply-To: <2B9C97B395470A40B9E9E5D469BCD9FA01568A09@EU-MBX-03.mgc.mentorg.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1291151110787693783==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fahad,

On 02/14/2014 10:06 AM, Arslan, Fahad wrote:
> Hi,
>
> I'm using bluez4_4.101 and ofono-1.13. If I start ofono first and then
> bluetooth, rfcomm kernel module is not loaded. But if bluetooth is
> started first things work perfectly.
>
> I tried using ofono-1.12 and it works fine irrespective of the execution
> sequence. I think changes introduced in ofono-1.13 and/or above are
> causing this but not sure.
> Any idea or pointers?
>

Have you tried configuring oFono with '--enable-bluez4'?  As of 1.13, =

oFono configures with BlueZ5 support by default.

Regards,
-Denis


--===============1291151110787693783==--

