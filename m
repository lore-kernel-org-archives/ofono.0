Content-Type: multipart/mixed; boundary="===============3208796291673337573=="
MIME-Version: 1.0
From: Jupiter <jupiter.hce@gmail.com>
Subject: Failed re-register, a bug or feature? (Original Failed to reconnect)
Date: Sun, 22 Nov 2020 14:38:19 +1100
Message-ID: <CAA=hcWSJ_=+-PSb1trki-kr0qTSNkH6sNUemvoQb_FiQ-=fJZA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3208796291673337573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

After a few hours debugging, I think that the cause of ofono failed to
re-register at following (4) is that netreg_status_changed is not
called, the ofono checks signalling strength level RSSI, RSRQ and
RSRP, but that is not going to work when the modem changes
registration status not be be registered.

Could any ofono developer kindly shed light upon if that is ofono
feature or bug? If I was looking in the wrong direction, could you
point me in the right direction to fix that issue?

Thank you.

Kind regards,

- jupiter





On 11/21/20, Jupiter <jupiter.hce@gmail.com> wrote:
> Hi,
>
> My apology for keeping a post on the topic to seek list helps.
>
> After changing testing tactics, I now believe it could be something
> wrong, missing or bug in ofono, hope someone could kindly respond to
> shed some light on the cause.
>
> Here is my new test:
>
> (1) I pulled antenna out before starting ofonod, it failed network
> which was good.
>
> (2) I plugged antenna, ofono could connect to the network
> automatically (which was good)
>
> (3) I pulled the antenna out again, the network broken.
>
> (4) I plugged the antenna again, ofono was not able to connect to the
> network again.
>
> If the ofono could connect to the network automatically at (2), it
> should be able to connect to the network automatically at (4), right?
> What are the differences between (2) and (4)?
>
> (5) I had to restart ofono to get the network connected.
>
> Could you please advise how to get ofono to reconnect at (4)? Or could
> you please point me a direction on how to resolve it?
>
> Please let me know if you need more debugging.
>
>
> Thank you.
>
> Kind regards,
>
> - j
>


--
"A man can fail many times, but he isn't a failure until he begins to
blame somebody else."
-- John Burroughs
--===============3208796291673337573==--

