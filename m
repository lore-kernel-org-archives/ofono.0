Content-Type: multipart/mixed; boundary="===============0784693939426878639=="
MIME-Version: 1.0
From: David Ashley <dashxdr@gmail.com>
Subject: Re: ofono with sim5320 module
Date: Thu, 21 Dec 2017 16:20:15 -0600
Message-ID: <CABkE59D-pCVccSW=gFwtzXOMm=m8fQst=Wvk4da_=r0vV0VQoA@mail.gmail.com>
In-Reply-To: <CABkE59AjrNxZFeGdCzstM8UAka75EbptwjMR3pV5VtWsrjQ_RQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0784693939426878639==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Just for closure since this thread appears high up in google search
for "sim5320 cmux problem"...

I got the cmux functionality of the SIM5320 module working reliably,
outside ofonod, but the answer would apply there (and elsewhere). The
key is to set the cmux line discipline mtu to 120 bytes (or possibly
as high as 127 bytes). When the cmux is activated and pppd is spawned
on one of the virtual serial ports, certain network packets want to
send a big chunk of data into the TX pipleline, and the SIM5320 cmux
support can't handle it. The sim5320 never sends more than 120 bytes
at a time to the virtual serial ports, so that was a clue right
there...

mtu 120 works, up to 126 works. I didn't try 127, but mtu set to 128
and higher fails.

-Dave

On 3/8/16, David Ashley <dashxdr@gmail.com> wrote:
> Well this project seems to be dead. Anyway for what it's worth, the
> problem turned out to be some difference between the AT+CMUX behavior
> betwene the sim900 and the sim5320 module. When I tore out all the MUX
> related code the 3G / internet / ppp aspects all just start working.
>
> -Dave
>
> On 3/7/16, David Ashley <dashxdr@gmail.com> wrote:
>> Hello, I'm at my wits' end trying to get ofono working with the
>> sim5320 module. I'm using the plugins/sim900.c module as a starting
>> point. I think the issue has something to do with the difference
>> between the MUX functionality between the 900 and the 5320.
>

--===============0784693939426878639==--

