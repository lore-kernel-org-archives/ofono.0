Content-Type: multipart/mixed; boundary="===============5453557639105930863=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: Re: Telit HE910 initialisation sequence freezes
Date: Fri, 06 Sep 2013 07:35:48 +0200
Message-ID: <522969B4.8050806@hale.at>
In-Reply-To: <CAMtf1D9cQMJpJ+CngRzWYH+xEqfe_5UBQudf3hMQibi2n13frw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5453557639105930863==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Etienne,

On 05/09/13 09:54, Etienne Mabille wrote:
> Hi everyone,
>
> I am using the Telit HE910 modem with the "telit: rework for HE910" =

> patches shared by Jonas Bonn on the 4th of april 2013.
>
> After some endurence testing I realize that sometimes (around 25% of =

> the time) the initialisation process freezes after switching sim state =

> satus to 2.
> I assume that the driver then waits for a signal from the modem, but =

> this signal never comes.
> When this happens, the only way I found is to hard-reset the modem...
> Is there a way to stimulate the modem in order to continue the =

> initialisation sequence ?
>
> Thanks in advance,
>
> Etienne

What's the firmware version of your modem? I noticed that behaviour with =

firmware versions below 12.00.003.

Regards,
Christopher

--
Scanned by MailScanner.


--===============5453557639105930863==--

