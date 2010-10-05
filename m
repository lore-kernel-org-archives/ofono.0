Content-Type: multipart/mixed; boundary="===============2149072630291129142=="
MIME-Version: 1.0
From: Alexander Kanavin <alexander.kanavin@nokia.com>
Subject: return values of org.ofono.SupplementaryServices.Initiate
Date: Tue, 05 Oct 2010 13:28:55 +0300
Message-ID: <4CAAFDE7.8050109@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2149072630291129142==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

doc/supplementaryservices-api.txt says nothing about return values of =

SupplementeryServices.Initiate method (or that the method can take SS =

requests in addition to USSD). Can the API designer/implementer fix this =

please?

string, variant Initiate(string command)

			Sends a USSD command string to the network
			initiating a session.  When the request is handled
			by the appropriate node of the network, the
			method returns the response or an appropriate
			error.  The network may be awaiting further response
			from the ME after returning from this method and no
			new command can be initiated until this one is
			cancelled or ended.

			Possible Errors: [service].Error.Timedout
			Possible Errors: [service].Error.Canceled

Regards,
Alex

--===============2149072630291129142==--

