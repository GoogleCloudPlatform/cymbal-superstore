
import request from "supertest";
import app from "./index";
import {describe, expect, it, test} from '@jest/globals';
import express, { Express, Request, Response } from "express";

describe('GET /health', () => {
	it('should return a 200 status code', async () => {
		const response = await request(app)
			.get('/health');
		expect(response.statusCode).toBe(200);
    expect(response.text).toBe('✅ ok');
	});
});

describe('GET /', () => {
	it('should return a 200 status code', async () => {
		const response = await request(app)
			.get('/');
		expect(response.statusCode).toBe(200);
    expect(response.text).toBe('🍎 Hello! This is the Cymbal Superstore Inventory API.');
	});
});

// Test GET /newproducts
// ⭐️ DEMO BEGINS HERE 

