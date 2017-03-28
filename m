Content-Type: multipart/mixed; boundary="===============8328475117256985758=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] qmimodem: add protection against modem_unregister
Date: Tue, 28 Mar 2017 14:28:09 -0500
Message-ID: <0014b080-6825-25de-7cc9-7f19a180c0a4@gmail.com>
In-Reply-To: <1490716066-26812-1-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8328475117256985758==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On 03/28/2017 10:47 AM, Lukasz Nowak wrote:
> From: Lukasz Nowak <lnowak@tycoint.com>
>
> The qmimodem driver sets up numerous timeouts, passing internal
> data structures to them as user_data. If a physical modem device
> is removed, udev will call modem_unregister, which in turn will
> call gobi_remove(). That function calls qmi_device_unref() which
> frees all internal data structure memory inside qmidriver.
>
> If a timeout is in progress while the usb device is removed,
> the callback function will operate on already freed memory,
> causing unpredicatble results. In some cases nothing bad will
> happen, in others - segfault.
>
> In order to solve this problem, store all created timeouts in
> a list, and when the driver data is freed in qmi_device_unref()
> remove all active timeout sources.
> ---
>  drivers/qmimodem/qmi.c | 60 ++++++++++++++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 54 insertions(+), 6 deletions(-)
>

I don't think tracking the various timeouts is the right approach.  I =

attempted a slightly different fix, see the patch 'qmi: track discovery ...'

It is completely untested and doesn't handle qmi_device_shutdown (I have =

no idea what to do with that one honestly).  Can you please =

test/review/fix it up and see if it addresses the hot-removal issues.

Regards,
-Denis

--===============8328475117256985758==--

