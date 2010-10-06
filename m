Content-Type: multipart/mixed; boundary="===============8203017319517573812=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC online/offline atoms PATCH 2/4] sms: watch modem state
Date: Tue, 05 Oct 2010 19:38:33 -0500
Message-ID: <4CABC509.2080502@gmail.com>
In-Reply-To: <1286279995.17473.81.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8203017319517573812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 10/05/2010 06:59 AM, Marcel Holtmann wrote:
> Hi Pekka,
> =

>> Allow use of SMS atom in online and offline states.  The messages are
>> queued but not sent in offline mode. Errors occurring when an SMS is
>> being sent while transition from online to offline are handled
>> gracefully.
> =

> do we really want this? How is this suppose to work from the user
> experience. I think just failing SendMessage with a proper error is a
> more clear indication.

That is a valid point, the code should be able to handle this use case,
but from a UI stand point I don't know what is better.

The main reason for moving sms atom from online to offline is the
ability to switch the settings.  In particular the SMSC address which is
stored on the SIM.

Regards,
-Denis

--===============8203017319517573812==--

