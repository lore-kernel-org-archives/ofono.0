Content-Type: multipart/mixed; boundary="===============7985551957378431392=="
MIME-Version: 1.0
From: Yevhen Kyriukha <kirgene@gmail.com>
Subject: Dealing with modem hangs
Date: Mon, 24 Mar 2014 22:45:14 +0200
Message-ID: <CADV-EXG+jXowODbok4Yqf1OCYQxKGA9oodsQmVt0MqpJ08ZGUw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7985551957378431392==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I use 3G modems connected to unattended terminals for a long time.
I use ofono for managing 2G connections.

All this time I'm suffering from modem hangs: during establishing 2G
connection modem may hang, i.e. it stops reacting on AT commands to
specific port.
I'd tested a lot of modems of different brands before selecting one.
And I have to say that *every* model has such issue.

So I created a workaround for this (patched ofono):
When I send AT command I start a timer that fires when no response is
received during some timeout. So if timeout is reached I send
AT+CFUN=3D1,1
command that makes modem reset.
After that modem can be usable again.

I was surprised that ofono doesn't have such functionality.

So I think ofono should have some sort of mechanism to reset the modem
if it stops responding.
What do you think?

-- =

Best regards,
Yevhen

--===============7985551957378431392==--

