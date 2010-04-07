Content-Type: multipart/mixed; boundary="===============6452626836567239238=="
MIME-Version: 1.0
From: Nicola Mfb <nicola.mfb@gmail.com>
Subject: Re: [PATCH 2/2] Added SQLite history plugin
Date: Wed, 07 Apr 2010 19:43:39 +0200
Message-ID: <p2p359c5481004071043id03de442n419b3ff6c39e6c88@mail.gmail.com>
In-Reply-To: <201004071233.50561.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6452626836567239238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 7, 2010 at 7:33 PM, Denis Kenzior <denkenz@gmail.com> wrote:
[...]
>> A similar lack of robustness exists at the modem API side as well, if oF=
ono
>> =C2=A0crashes/runs out of battery after receiving the message from the m=
odem
>> =C2=A0driver the message is lost. There is no provision in the SMS modem=
 API to
>> =C2=A0signal back to the modem driver that the message has been successf=
ully
>> =C2=A0stored on the APE.
>
> If oFono crashes/runs out of battery here the driver is gone along with o=
Fono.
> Notifying it of anything is not going to help ;)

Yes, anyway I'm thinking about the case when the storage system is
full, or an other error occours while trying to store the message.
In this case the driver should notify the network with a NACK, while a
signal should notify the user that the storage is full or there is
another problem.

      Niko

--===============6452626836567239238==--

