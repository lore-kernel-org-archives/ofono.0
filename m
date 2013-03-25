Content-Type: multipart/mixed; boundary="===============6341927779083240460=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: when to set a Modem online
Date: Mon, 25 Mar 2013 10:34:24 -0500
Message-ID: <51506E80.40402@gmail.com>
In-Reply-To: <CABvLYuCcfYBrNWETbSGbWm=Mem5Mh9q4nuKYQre9tmj7C5=e3Q@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6341927779083240460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Cedric,

On 03/25/2013 09:34 AM, Cedric Jehasse wrote:
> Hi,
>
> On Huawei devices i need to wait for the pin to be entered before
> setting the Online property to true.

Then wait for the SubscriberIdentity to be signaled.  This is similar to =

how connman works.  See tools/auto-enable.c for a more detailed example.

Going Online before the PIN is entered is really only for voice modems =

and emergency mode.

> For this i'm waiting for the Interfaces dict to contain
> org.ofono.ConnectionManager.
> Now i'm trying an Option dongle, the org.ofono.ConnectionManager
> interface is only added after the Online property is set.

Sounds like the option driver was never converted fully.  Care to move =

the GPRS stuff into post_sim and see if anything breaks?

>
> So checking which interfaces are available isn't a good way to check
> when i can set a modem Online.
> Is there a good way to know the modem is in MODEM_STATE_OFFLINE, and
> we can set the Online property?
>

Regards,
-Denis

--===============6341927779083240460==--

