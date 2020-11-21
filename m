Content-Type: multipart/mixed; boundary="===============2296781435501647724=="
MIME-Version: 1.0
From: Jupiter <jupiter.hce@gmail.com>
Subject: Re: Failed to reconnect after 4G LTE signaling strength level is back
Date: Sat, 21 Nov 2020 16:21:24 +1100
Message-ID: <CAA=hcWTzKoPC6ih9MWJxebBRdzymSOBiLHmS-_YW_G9W3R9+iw@mail.gmail.com>
In-Reply-To: <CAA=hcWRV7hQ6eo2YsR0NOa3fjt3C0hVwo8yRgJqBhuuwSQ38nw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2296781435501647724==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

My apology for keeping a post on the topic to seek list helps.

After changing testing tactics, I now believe it could be something
wrong, missing or bug in ofono, hope someone could kindly respond to
shed some light on the cause.

Here is my new test:

(1) I pulled antenna out before starting ofonod, it failed network
which was good.

(2) I plugged antenna, ofono could connect to the network
automatically (which was good)

(3) I pulled the antenna out again, the network broken.

(4) I plugged the antenna again, ofono was not able to connect to the
network again.

If the ofono could connect to the network automatically at (2), it
should be able to connect to the network automatically at (4), right?
What are the differences between (2) and (4)?

(5) I had to restart ofono to get the network connected.

Could you please advise how to get ofono to reconnect at (4)? Or could
you please point me a direction on how to resolve it?

Please let me know if you need more debugging.


Thank you.

Kind regards,

- j
--===============2296781435501647724==--

