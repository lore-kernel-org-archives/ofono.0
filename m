Content-Type: multipart/mixed; boundary="===============3134181200472787421=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: Access to SIM card when Modem is not "Powered"
Date: Tue, 30 Mar 2010 14:39:16 +0300
Message-ID: <80fd4e751003300439j527f1934ic95dabcfe46f545c@mail.gmail.com>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C9C12B87DB@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3134181200472787421==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/3/29 Bastian, Waldo <waldo.bastian@intel.com>:
> Pekka Pessi wrote:
>> I've been porting the N900 modem control code to oFono. The semantics
>> of Powered is fine with respect of the atoms, in other words, if the
>> modem crashes and boots itself, all the atoms are flushed nicely.
>> When powering up, the Powered can be set to true when the modem is
>> really up and running.
>
> Do you have an overview of the different modes and transitions that the N=
900 modem control is using today?

Not really. What do you want to know? There are some design documents
describing GPIO line usage, something about SSI used for phonet
messages and how modem bootloader interacts with it, and documents
about the MTC design and different MTC states.

-- =

Pekka.Pessi mail at nokia.com

--===============3134181200472787421==--

