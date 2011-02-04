Content-Type: multipart/mixed; boundary="===============6974592990132570485=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Regarding Network Scan
Date: Fri, 04 Feb 2011 09:52:02 -0600
Message-ID: <4D4C20A2.2000802@gmail.com>
In-Reply-To: <AANLkTinB7Nq5GV=BY7WZ-TwOUMy9epL6N3yaSyJmMnKO@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6974592990132570485==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sankar,

On 02/04/2011 06:38 AM, Sankar wrote:
> Hi,
> =

> Using the Scan method call on the NetworkRegistration interface, I can
> query the available networks in the current region. Is there a way I can
> cancel this scan operation.?

We currently do not support AT command cancellation.  Lots of AT modems
do not handle this properly or only support cancellation of a few
specific AT commands (e.g. COPS scan and sometimes ATD)

Regards,
-Denis

--===============6974592990132570485==--

