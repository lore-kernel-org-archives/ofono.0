Content-Type: multipart/mixed; boundary="===============8592923609232744182=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/1] Limits the send sms retry to network timeout
Date: Thu, 17 Mar 2011 12:24:41 -0500
Message-ID: <4D8243D9.8070809@gmail.com>
In-Reply-To: <1300382431-4019-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8592923609232744182==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 03/17/2011 12:20 PM, Jeevaka Badrappan wrote:
> Hi,
> =

>   If sending of SMS fails, then oFono core will try to resend it after
> n * 5 seconds(n =3D retry count). Due to this, conformance test case
> 27.22.8 sequence 1.4 fails(refer 31.124 spec). Plan is to limit the
> failue codes for which the retry will be done. This patch allows the
> retry if the failure is only due to network timeout. For all the other
> failure cases, retry is not done.

Patch has been applied, thanks.

Regards,
-Denis

--===============8592923609232744182==--

