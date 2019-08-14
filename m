Content-Type: multipart/mixed; boundary="===============9021151195456876089=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: Unsalble cellular connection
Date: Wed, 14 Aug 2019 15:00:09 +0200
Message-ID: <315c5382-35c5-2407-d7c6-9fb198ae4f8b@norrbonn.se>
In-Reply-To: <CAA=hcWTH2Ayb=OtWim7h_AX+0haoq_GZ5ZYGHbOLkCMq+zr6=A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9021151195456876089==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi JH,

On 14/08/2019 13:11, JH wrote:
> Hi Jonas,
> =

> On 8/14/19, Jonas Bonn <jonas@norrbonn.se> wrote:
>> So you have no traffic over the LTE link?  How do you know that it goes
>> down after 1-2 hours... maybe it went down after 5 minutes?
> =

> I logged link status every 10 minutes.

How?  Not clear from what you posted earliest how you can tell that the =

link has gone down.  The default route is set to go over WiFi so a =

generic ping isn't sufficient.  What exactly are you monitoring?

> =

>> Cloud messages are as good as a ping... a packet's a packet.
>> The link is configured by connman, not ofono.  ofono just publishes the
>> address details so that connman can set it up.
> =

> So, it is back to connman?

Well, the log _seemed_ to indicate that connman does an NTP request to a =

server that isn't available and thereby decides to take the link down... =

off the top of my head I can't say whether that's something connman =

actually does so hopefully somebody else will jump in here.  Did ofono =

indicate the context as still established after that?

> =

>>>> No Address?  No Interface?  Running ofono with debug output will
>>>> probably shed some light on what's going on here.
>>>
>>> I think that could be because I only ran it once, if I ran
>>> list-contexts 4 times consecutively, every time it displayed different
>>> results included address and interface, is it the normal behaviour of
>>> list-contexts?
>>
>> Sounds broken...???
> =

> Which one is broken, ofono or connman or something else? There is not
> much configurations for both ofono and connman,

I was referring to the DBus response containing incomplete Settings =

objects.  A random set of properties at each request is not the =

documented behaviour.

> =

> Can the defect hardware particularly the system power supply caused
> the link down? I have only one test device, I cannot prove it. The
> SATA chip has a pin for power up, During the boot, a command to set
> the power up before ofono is running. When the link is down, either I
> restart the ofonod or I called the command to turn the power up again,
> both can bring the link back. I cannot image the chip could lose
> power, but if the system power supply is not stable in some stage too
> low to support the SARA chip, will it trig the power down? I talked to
> the hardware engineer who rejected that it did not make sense because
> WiFi was running fine, he is pointing the figure to the modem manager
> and connection manager.

Seeing the issue with complete logs would be useful.  I thought your =

previous logs indicated connman trying to deactivate the context when it =

took the link down, but the ofono logs didn't show any of that... what's =

going on there?

/Jonas

> =

> Thank you.
> =

> Kind regards,
> =

> - jh
>=20

--===============9021151195456876089==--

