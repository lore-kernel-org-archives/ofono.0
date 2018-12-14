Content-Type: multipart/mixed; boundary="===============5229698591364484276=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH] sim: Sim PIN1 cache upon modem reset/crash
Date: Fri, 14 Dec 2018 10:19:39 +0100
Message-ID: <45f1f97e-d04b-253b-e897-ae30b9deadeb@kerlink.fr>
In-Reply-To: <20181213220628.GA3237@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5229698591364484276==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 12/13/18 11:06 PM, Pavel Machek wrote:
> On Thu 2018-12-13 23:01:45, Pavel Machek wrote:
>> Hi!
>>
>>> If a firmware crashes on a device with a PIN lock and the user was brow=
sing
>>> the internet at that time, it would be quite intrusive to interrupt the=
 user
>>> and prompt them for a PIN (after all, they already entered the PIN).
>>> Additionally, if the PIN was stored for just this case and the firmware
>>> reboots fast enough, a crash might not even be noticed by the user at a=
ll.
>>> Now one can argue that the firmware shouldn't crash, and I agree, but
>>> realistically the chances of that never happening are NIL.
>> Can I have another scenario?
>>
>> User is waiting for important call, phone in his pocket, expecting it
>> to ring. Firmware crashes, reboots... and asks for a PIN.
>>
>> When the important call comes, phone is not available... as it is
>> waiting for PIN...
> And when user realizes what happened, he disables the PIN on his SIM
> card. When his phone is stolen, thief is able to do many expensive
> calls on his account...
>
> 									Pavel

Just my 2 cents on this subject.

I used to develop phone firmwares 15 years ago back when we did not have
a kernel inside a phone. This means that any application (mail, WAP,
your favorite game, L1, ...) crash ends up in a phone reboot. Of course
PIN was not asked in this case. Feature name was "silent reboot" if I
remember well.

So I do confirm this used to be implemented. Maybe it was not compliant
with 3GPP and a security hole, maybe it was a bad idea.

Christophe Ronco



--===============5229698591364484276==--

