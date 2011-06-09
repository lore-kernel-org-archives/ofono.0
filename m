Content-Type: multipart/mixed; boundary="===============8655388062121330535=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Call Logs
Date: Thu, 09 Jun 2011 11:17:56 +0200
Message-ID: <1307611084.2589.22.camel@aeonflux>
In-Reply-To: <BANLkTina8iSM1tgBK738OHDe7pOo-NtPug@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8655388062121330535==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rishi,

> One Quick question. Does oFono Support any Call Loggin mechanism ???
> It says that it handles call history via plugin interface and not
> directly.
> Can anyone please elaborate on the same ??

call logs are always specific to the system you are using oFono on. It
depends on your contacts, SMS and call log database system. So oFono
provides details via its history interface and you can have multiple
plugins for it. However the integration work is specific to your system
since there is no standard for call logs.

Regards

Marcel



--===============8655388062121330535==--

