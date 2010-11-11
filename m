Content-Type: multipart/mixed; boundary="===============7529894230728386818=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: PPP disconnected via Huawei modem
Date: Thu, 11 Nov 2010 10:09:04 -0600
Message-ID: <4CDC1520.6000906@gmail.com>
In-Reply-To: <AANLkTimyMY0Y3hf7wA=rJghB5MtVLgeji7wQ+VUr9anf@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7529894230728386818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Elton,

On 11/11/2010 01:14 AM, Chen Yuwei wrote:
> Hi,
>  =

> I use MeeGo NB 10/26 release to browse some website via Huawei modem,
> The PPP connection is disconnected when recieve a PPP event (RXJ-).
> Then the PPP can not be connected anymore. Why?
> What condition does ofono recieve this event?

We won't really know unless we have a detailed protocol trace.  Have you
tried running gatchat/gsmdial to reproduce this problem?  That
application has the ability to dump a detailed trace of the ppp packets.

See if you can reproduce the issue with gsmdial and include the ppp dump
file.

Regards,
-Denis

--===============7529894230728386818==--

