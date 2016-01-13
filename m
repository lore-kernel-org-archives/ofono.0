Content-Type: multipart/mixed; boundary="===============7419495498416724194=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Huawei 3131 with idVendor=12d1, idProduct=14fe
Date: Wed, 13 Jan 2016 10:04:23 -0600
Message-ID: <56967587.3020007@gmail.com>
In-Reply-To: <CADnUhn3Q2dMD69JVdhyX1Pz0PjzEQ3fjmrnKxjscwV51JgKDHw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7419495498416724194==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matti,

On 01/13/2016 04:40 AM, matti kaasinen wrote:
> Denis,
> I made this change. I did not see any change in logs apart from in
> "atmodem" had changed to "huaweimodem". However, at commands were the
> same in there. One difference was that test/activate-context did not
> return with error messages. In fact it did not print anything. Also no
> at commands were produced. Also no service was produced visible from
> connmand.

Was your modem online?  activate-context won't print anything unless an =

error occurred.

>
> I made more of these "atmodem" -> "huaweimodem" modifications. All Error
> messages from ofono logs apart from one were removed. However, operation
> was the same.

No, please don't do that.  The rest of your changes are wrong actually.

>
> I did not find AT^NDISDUP from log even though it seemed to be some in
> drivers/huaweimodem/gprs-context.c.

Feel free to send the AT trace.

>
> Please find the patch below, if you can find any use of it as it really
> was not enough making things work.
> I must try something else as I'm running out of time now.
> Anyhow, thank for your assistance Denis.
>
> Thanks,
> Matti
>

No problem, likely you're pretty close to getting it to work.

Regards,
-Denis

--===============7419495498416724194==--

