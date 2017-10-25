Content-Type: multipart/mixed; boundary="===============8403909284255291412=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: Re: Ofono 1.21 crashes with Sierra MC7455
Date: Wed, 25 Oct 2017 18:04:09 +0200
Message-ID: <56b26950-2bb6-e740-9365-13ac25856226@kerlink.fr>
In-Reply-To: <8935996d-f4e9-9d6b-2d0b-6639a584c972@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8403909284255291412==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On 10/25/2017 05:39 PM, Denis Kenzior wrote:
> Hi,
>
> On 10/25/2017 07:38 AM, Eswaran Vinothkumar (BEG/PJ-IOT-EL) wrote:
>> Hello,
>>
>> For our next connectivity project we are planning to use Connman =

>> along with oFono
>>
>> The version being used are Connman :1.35 and oFono:1.21
>>
>> After system start up, I am seeing that the oFono process gets =

>> exited, whenever I try to enable the modem by calling the python =

>> script enable-modem in the test directory. However, if I restart the =

>> ofono systemd service, everything works fine.
>>
>> I have attached the logs for your reference. Please let me know, if =

>> any further log messages are required.
>>
>
> I see no backtrace in your logs, so there's really nothing to go on =

> here.=C2=A0 Are you sure its oFono crashing and not systemd simply killin=
g =

> it for whatever reason?=C2=A0 Can you attach gdb to get the backtrace?
>

I assume Ofono has been built using Yocto and traces are output using =

syslog (because traces look similar to what I have).

I am in the same case here and I never see backtrace when abort occurs. =

I haven't fixed that yet even locally. Usually when I need to debug a =

crash, I deactivate Ofono signal handling, get a core dump and analyze =

the core.

Maybe that can be done here.


Christophe



--===============8403909284255291412==--

