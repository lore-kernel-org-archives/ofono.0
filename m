Content-Type: multipart/mixed; boundary="===============4642033146572687804=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] qmimodem: include shutdown in callback cleanup queue
Date: Mon, 03 Apr 2017 13:19:28 -0500
Message-ID: <10a64355-5590-8a73-35b2-ef45cf9a7531@gmail.com>
In-Reply-To: <1490881865-16372-2-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4642033146572687804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On 03/30/2017 08:51 AM, Lukasz Nowak wrote:
> From: Lukasz Nowak <lnowak@tycoint.com>
>
> Create a unified callback_data structure, used for all timeout callbacks.
> This allows to maintain a single callback_queue, which cancels any active
> timeouts, and frees callback data memory when a usb device is hot unplugg=
ed.
> ---
>  drivers/qmimodem/qmi.c | 401 ++++++++++++++++++++++---------------------=
------
>  1 file changed, 180 insertions(+), 221 deletions(-)
>

I didn't like how invasive this approach was, and also the union was a =

bit ugly as it required all the weird data structures to be defined =

first.  They were no longer local to actual functions that utilized them.

Please check [PATCH] qmi: Optimize structure allocations.  That one =

should simplify things quite a bit as well.  Not tested on my end, so =

please let me know / fix it if it is broken.

Regards,
-Denis

--===============4642033146572687804==--

