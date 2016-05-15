Content-Type: multipart/mixed; boundary="===============1092915061508613709=="
MIME-Version: 1.0
From: Georg Chini <georg@chini.tk>
Subject: Re: Method "Register" with signature "oay" doesn't exist
Date: Sun, 15 May 2016 12:39:56 +0200
Message-ID: <573851FC.3090203@chini.tk>
In-Reply-To: <57385147.6030701@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1092915061508613709==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 15.05.2016 12:36, Marco Trapanese wrote:
> Il 15/05/2016 12:32, Georg Chini ha scritto:
>
>> Yes, loopback modules are created automatically. The error message =

>> you are getting is relevant,
>> but the problem is rather somewhere on the bluetooth side. From my =

>> experience the fact that
>> you get A2DP connected does not mean that HFP is working as well. =

>> Take a look at the debug
>> logs of ofono, pulseaudio  and bluetoothd and at the dbus messages =

>> that are passing between
>> the different components. Maybe you'll find a hint there what is =

>> going wrong.
>
> I sent the logs on the pulseaudio mailing-list.
> Unfortunately I haven't enough knowledge to understand what's happening.
>
> I will try again to get fresh logs and I will post them here.
I've only seen the pulseaudio logs. ofono and bluetoothd also might =

provide some information.
Try also dbus-monitor --system. You should see the messages passing =

between the components.

>
>> Did you set headset=3Dofono for module-bluetooth-discover?
>
> Yes, I did
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono


--===============1092915061508613709==--

