Content-Type: multipart/mixed; boundary="===============5267892555384377798=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Question about set modem power state to off
Date: Tue, 06 Jul 2010 08:58:52 -0500
Message-ID: <4C33369C.2070101@gmail.com>
In-Reply-To: <D87B22B1FE8C0F479CA9BEAD6C25AAE805101805@ism-mail03.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5267892555384377798==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

On 07/05/2010 09:51 PM, Zhang, Caiwen wrote:
> Hi all,
>  =

> When set modem power state to off, all atoms and interfaces except
> 'org.ofono.Modem'  are
>  =

> removed and unregistered. So all APIs execpt 'org.ofono.Modem'  can not
> be used after that.
>  =

> But,  when modem power state is off (AT+CFUN=3D0), some feature should
> still be available. such
>  =

> as access SIM card(import contact from SIM) and STK.  I think maybe
> ofono should at least keep 'phonebook'
>  =

> and 'stk' atom after set power state to off.
>  =


What you're thinking of here is the 'Online' property of the Modem which
controls the RX/TX circuit status.  When Online is False and Powered is
True the modem can still access the SIM.  Once the modem is powered off,
it is truly off.

This feature is still in development and thus no driver is currently
taking advantage of this functionality.

Regards,
-Denis

--===============5267892555384377798==--

