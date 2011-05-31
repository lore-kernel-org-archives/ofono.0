Content-Type: multipart/mixed; boundary="===============3681632710950762358=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Add support to huawei e173
Date: Tue, 31 May 2011 11:47:07 -0500
Message-ID: <4DE51B8B.6010504@gmail.com>
In-Reply-To: <BANLkTik1d1YW31TJ=ZYuZ8zFOMLhvfuTQQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3681632710950762358==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Leonardo,

On 05/30/2011 04:11 PM, Leonardo Luiz Padovani da Mata wrote:
> hello dudes, what i need to do to check if the implemented drivers are
> enough to support a modem? Do i just need to add the rules for udev? how
> do i do that?
> =

> The id of the modem is  12d1:1c0b huawei e173
> =


Check plugins/ofono.rules in git.  It looks like a rule is not present
for this particular device id.

You will have to do some minor poking around to figure out what tty
corresponds to what function (e.g. Pcui, Modem, see other Huawei rules
for examples), add a new entry to ofono.rules and try to see if it works.

Regards,
-Denis

--===============3681632710950762358==--

