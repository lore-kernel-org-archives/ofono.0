Content-Type: multipart/mixed; boundary="===============0512359248518454929=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: Re: Enhancing mmsd
Date: Fri, 24 Feb 2012 15:44:05 +0100
Message-ID: <4F47A235.40807@linux.intel.com>
In-Reply-To: <4F4790D5.3040608@vfnet.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0512359248518454929==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On 02/24/2012 02:29 PM, Jens Rehsack wrote:
> Hi,
>
> as announced in my last mail, I'm here to work with + improve ofono
> and related software.
>
> My next task will be to implement an ofono plugin which handles some
> UPL push messages. Because there is only one "listener" at
> org.ofono.PushNotificationAgent possible, I see two and a half way
> to go on:
>
> 1) fork ofono-mmsd to handle more message types than mms
>     (via plugins?)
>     1b) fork ofono-mmsd to handle only SUPL push messages
> 2) find a way for more listeners on push messages
>
> Any suggestions, preferred ways?
>
> Best regards and have a nice weekend,
> Jens
>

I think there is a third way to do what you want : write a SUPL push =

message consumer as an mmsd plugin and not as an ofono plugin. Actually, =

mmsd already implements a WAP push message dispatch mechanism for other =

push message than MMS.
To check if this fits your needs, please have a look at the consumer.txt =

documentation from mmsd/doc/.

Best regards.
Have a nice week-end,

Ronald

--===============0512359248518454929==--

