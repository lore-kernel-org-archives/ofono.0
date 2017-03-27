Content-Type: multipart/mixed; boundary="===============7588055444044931187=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v5 1/2] qmimodem: add protection against modem_unregister
Date: Sun, 26 Mar 2017 22:39:04 -0500
Message-ID: <763e48fc-6a6a-9619-3397-ba6ea8107a2d@gmail.com>
In-Reply-To: <1490604978-10639-2-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7588055444044931187==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On 03/27/2017 03:56 AM, Lukasz Nowak wrote:
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
> In order to solve this problem, add calls to qmi_device_ref
> before setting up each timeout. Then inside callbacks, check
> if this is the last reference (i.e. gobi_remove() has been called).
> If that happens, do not operate on memory, just clean-up and exit.

No, this is not the right way of doing this.  The proper way to do this =

is to store the glib gsource identifier for every timeout and remove =

that timeout in the appropriate place / time.

I only see about 5 g_timeout_add calls inside qmi.c where the return =

value isn't saved off.  So you probably need to go through these and =

save the gsource id in the appropriate data structure.

Regards,
-Denis

--===============7588055444044931187==--

