const express = require('express');
const { OAuth2Client } = require('google-auth-library');
const app = express();

const client = new OAuth2Client('YOUR_GOOGLE_CLIENT_ID');  // use backend-specific client ID

app.post('/verify-token', async (req, res) => {
    const { idToken } = req.body;
    try {
        const ticket = await client.verifyIdToken({
            idToken,
            audience: 'YOUR_GOOGLE_CLIENT_ID',  // use backend-specific client ID
        });
        const payload = ticket.getPayload();
        const userId = payload['sub'];
        // Proceed with custom logic (e.g., create or retrieve the user in the database)
        res.status(200).send({ userId });
    } catch (error) {
        res.status(400).send('Invalid token');
    }
});

app.listen(3000, () => console.log('Backend running on port 3000'));
